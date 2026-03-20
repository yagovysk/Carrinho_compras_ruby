class ApplicationController < ActionController::Base
	around_action :set_locale

	def change_locale
		session[:locale] = permitted_locale(params[:locale])
		redirect_back fallback_location: store_index_path
	end

	private

	def set_locale(&action)
		I18n.with_locale(permitted_locale(session[:locale]), &action)
	end

	def permitted_locale(locale)
		locale = locale.to_s

		if I18n.available_locales.map(&:to_s).include?(locale)
			locale
		else
			I18n.default_locale.to_s
		end
	end
end
