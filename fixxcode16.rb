require 'xcodeproj'

# Path to your project's .xcodeproj file
project_path = 'ios/Runner.xcodeproj'

# Name of the target you want to modify
target_name = 'Runner'

# Open the Xcode project
project = Xcodeproj::Project.open(project_path)

# Find the target by name
target = project.targets.find { |t| t.name == target_name }

# Loop through each build configuration (e.g., Debug, Release)
target.build_configurations.each do |config|
  # Set the CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES to 'YES'
  config.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
end

# Save the updated project
project.save

puts "Updated CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES to 'YES' for target '#{target_name}'"
