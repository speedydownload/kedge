#!/usr/bin/env ruby
# Adds Ballast's three Screen Time extension targets to Runner.xcodeproj and
# wires the shared blocking sources into the Runner target.
#
# Run ON THE MAC, from the repo root, after `flutter build ios --config-only`:
#
#   gem install xcodeproj        # once
#   ruby tool/setup_ios_targets.rb
#
# Idempotent: re-running skips anything that already exists.

require 'xcodeproj'

PROJECT_PATH = File.expand_path('../ios/Runner.xcodeproj', __dir__)
DEPLOYMENT_TARGET = '16.0'
TEAM_NOTE = 'Set your Apple Team for every target in Xcode > Signing & Capabilities.'

EXTENSIONS = [
  {
    name: 'DeviceActivityMonitorExtension',
    bundle_id: 'app.ballast.ios.DeviceActivityMonitor',
  },
  {
    name: 'ShieldConfigurationExtension',
    bundle_id: 'app.ballast.ios.ShieldConfiguration',
  },
  {
    name: 'ShieldActionExtension',
    bundle_id: 'app.ballast.ios.ShieldAction',
  },
].freeze

project = Xcodeproj::Project.open(PROJECT_PATH)
runner = project.targets.find { |t| t.name == 'Runner' }
abort 'Runner target not found' unless runner

def ensure_group(project, name, path)
  project.main_group[name] || project.main_group.new_group(name, path)
end

def ensure_file(group, path)
  group.files.find { |f| f.path == File.basename(path) } || group.new_file(path)
end

def ensure_source(target, file_ref)
  already = target.source_build_phase.files_references.include?(file_ref)
  target.add_file_references([file_ref]) unless already
end

# ---- Shared source, member of all four targets --------------------------
shared_group = ensure_group(project, 'Shared', 'Shared')
shared_ref = ensure_file(shared_group, 'Shared/SharedBlocking.swift')
ensure_source(runner, shared_ref)

# ---- Runner: blocking sources + entitlements + deployment target --------
runner_group = project.main_group['Runner']
blocking_group = runner_group['Blocking'] || runner_group.new_group('Blocking', 'Blocking')
%w[BlockingChannelHandler.swift ActivityPickerPresenter.swift].each do |f|
  ensure_source(runner, ensure_file(blocking_group, "Blocking/#{f}"))
end

runner.build_configurations.each do |c|
  c.build_settings['CODE_SIGN_ENTITLEMENTS'] = 'Runner/Runner.entitlements'
  c.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = DEPLOYMENT_TARGET
end

# ---- Embed phase on Runner ---------------------------------------------
embed = runner.copy_files_build_phases.find { |p| p.name == 'Embed Foundation Extensions' }
unless embed
  embed = runner.new_copy_files_build_phase('Embed Foundation Extensions')
  embed.dst_subfolder_spec = Xcodeproj::Constants::COPY_FILES_BUILD_PHASE_DESTINATIONS[:plug_ins]
end

# ---- Extension targets --------------------------------------------------
EXTENSIONS.each do |spec|
  name = spec[:name]
  if project.targets.any? { |t| t.name == name }
    puts "skip   #{name} (already exists)"
    next
  end

  target = project.new_target(:app_extension, name, :ios, DEPLOYMENT_TARGET)
  group = ensure_group(project, name, name)
  ensure_source(target, ensure_file(group, "#{name}/#{name}.swift"))
  ensure_source(target, shared_ref)

  target.build_configurations.each do |c|
    s = c.build_settings
    s['PRODUCT_BUNDLE_IDENTIFIER'] = spec[:bundle_id]
    s['INFOPLIST_FILE'] = "#{name}/Info.plist"
    s['GENERATE_INFOPLIST_FILE'] = 'YES'
    s['CODE_SIGN_ENTITLEMENTS'] = "#{name}/#{name}.entitlements"
    s['IPHONEOS_DEPLOYMENT_TARGET'] = DEPLOYMENT_TARGET
    s['SWIFT_VERSION'] = '5.0'
    s['TARGETED_DEVICE_FAMILY'] = '1,2'
    s['MARKETING_VERSION'] = '1.0.0'
    s['CURRENT_PROJECT_VERSION'] = '1'
    s['CODE_SIGN_STYLE'] = 'Automatic'
  end

  runner.add_dependency(target)
  build_file = embed.add_file_reference(target.product_reference)
  build_file.settings = { 'ATTRIBUTES' => ['RemoveHeadersOnCopy'] }
  puts "added  #{name} -> #{spec[:bundle_id]}"
end

project.save
puts "saved  #{PROJECT_PATH}"
puts TEAM_NOTE
