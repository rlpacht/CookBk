EmberCLI.configure do |c|
  c.app :frontend,
    path:"frontend",
    enable: -> path { path.starts_with?("/app/") }
  c.build_timeout = 100
end
