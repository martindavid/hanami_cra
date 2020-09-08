require 'hanami/helpers'
require 'hanami/assets'
require 'hanami/middleware/body_parser'

module Api
  class Application < Hanami::Application
    configure do
      ##
      # BASIC
      #

      # Define the root path of this application.
      # All paths specified in this configuration are relative to path below.
      #
      root __dir__

      load_paths << %w[
        controllers
        validations
        presenters
      ]

      routes 'config/routes'


      middleware.prepend Rack::Cors do
        allow do
          origins ENV.fetch('FRONTEND_URL', '*')
          resource '*', headers: :any, methods: %i[get post put patch delete options head]
        end
      end
      middleware.use Hanami::Middleware::BodyParser, :json
      middleware.use Warden::Manager do |manager|
        manager.default_strategies :jwt_strategy
        manager.failure_app = Api::Controllers::Unauthorized
      end

      default_request_format :json
      default_response_format :json

      ##
      # SECURITY
      #
      security.x_frame_options 'DENY'
      security.x_content_type_options 'nosniff'
      security.x_xss_protection '1; mode=block'
      security.content_security_policy %{
        form-action 'self';
        frame-ancestors 'self';
        base-uri 'self';
        default-src 'none';
        script-src 'self';
        connect-src 'self';
        img-src 'self' https: data:;
        style-src 'self' 'unsafe-inline' https:;
        font-src 'self';
        object-src 'none';
        plugin-types application/pdf;
        child-src 'self';
        frame-src 'self';
        media-src 'self'
      }

      ##
      # FRAMEWORKS
      #

      # Configure the code that will yield each time Api::Action is included
      # This is useful for sharing common functionality
      #
      # See: http://www.rubydoc.info/gems/hanami-controller#Configuration
      controller.prepare do
        include Api::Controllers::Defaults
        include Api::Controllers::Authentication
        include Api::Controllers::Authorization
      end
    end

    ##
    # DEVELOPMENT
    #
    configure :development do
      # Don't handle exceptions, render the stack trace
      handle_exceptions true
    end

    ##
    # TEST
    #
    configure :test do
      # Don't handle exceptions, render the stack trace
      handle_exceptions true
    end

    ##
    # PRODUCTION
    #
    configure :production do
      # scheme 'https'
      # host   'example.org'
      # port   443

      assets do
        # Don't compile static assets in production mode (eg. Sass, ES6)
        #
        # See: http://www.rubydoc.info/gems/hanami-assets#Configuration
        compile false

        # Use fingerprint file name for asset paths
        #
        # See: https://guides.hanamirb.org/assets/overview
        fingerprint true

        # Content Delivery Network (CDN)
        #
        # See: https://guides.hanamirb.org/assets/content-delivery-network
        #
        # scheme 'https'
        # host   'cdn.example.org'
        # port   443

        # Subresource Integrity
        #
        # See: https://guides.hanamirb.org/assets/content-delivery-network/#subresource-integrity
        subresource_integrity :sha256
      end
    end
  end
end
