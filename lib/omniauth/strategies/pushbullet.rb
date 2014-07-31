module OmniAuth
  module Strategies
    class Pushbullet < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, "pushbullet"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
        :token_url => '/oauth2/token',
        :site => 'https://api.pushbullet.com',
        :authorize_url => 'https://www.pushbullet.com/authorize',
      }

      option :provider_ignores_state, true

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid { raw_info['iden'] }

      info do
        {
          :email => raw_info['email']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/v2/users/me').parsed
      end
    end
  end
end
