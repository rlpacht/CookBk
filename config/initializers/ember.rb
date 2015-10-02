EmberCLI.configure do |c|
  c.app :frontend,
    path:"/app/frontend",
    enable: -> path { path.starts_with?("/app/") }
  c.build_timeout = 10
end
