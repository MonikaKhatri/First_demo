OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
		provider :facebook, '641746849201971', '44fd219606ecdbdeb551bc4d2eab64e0'
end