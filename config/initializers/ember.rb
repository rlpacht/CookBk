EmberCLI.configure do |c|
  c.app :frontend,
    enable: -> path { path.starts_with?("/app/") }
  c.build_timeout = 20
end
