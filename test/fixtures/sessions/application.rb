module SessionsApp
  class Application < Lotus::Application
    configure do
      # Activate sessions
      sessions :cookie, secret: '1234567890'

      routes do
        post   '/set_session'  , to: 'sessions#new'
        get    '/get_session'  , to: 'sessions#show'
        delete '/clear_session', to: 'sessions#destroy'
      end
    end

    load!
  end


  module Controllers::Sessions
    include SessionsApp::Controller

    action 'New' do
      def call(params)
        session[:name] = params[:name]
        self.body = "Session created for: #{session[:name]}"
      end
    end

    action 'Show' do
      def call(params)

        self.body = session[:name]
      end
    end

    action 'Destroy' do
      def call(params)
        name = session[:name]
        session.clear
        self.body = "Session cleared for: #{name}"
      end
    end
  end

end
