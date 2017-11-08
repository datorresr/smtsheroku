
f = File.join(Rails.root, "config/aws.yml")

unless File.exists?(f)
  puts
  puts "-----------------------------------------------------------------------"
  puts "AWS config file missing. Please copy config/aws.yml.example"
  puts "to config/aws.yml and tailor its contents to suit your dev setup."
  puts
  puts "NB: aws.yml is excluded from git version control as it will contain"
  puts "    data private to your Ocean system."
  puts "-----------------------------------------------------------------------"
  puts
  abort
end

cfg = YAML.load(File.read(f))[Rails.env]

options = {
  region: ENV['AWS_REGION'],
  credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_ACCESS_KEY_ID'])
}
options[:endpoint] = cfg["endpoint"] if cfg["endpoint"]

Aws.config.update(options)
