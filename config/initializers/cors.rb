Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins ['http://localhost:3000', 'https://cbt.jjrsf.org', 'https://cbt-admin.jjrsf.org', 'https://jjrsf-cbt-admin.vercel.app'] # Add your frontend origin(s)
  
      resource '/api/*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        credentials: true
    end
  end
  