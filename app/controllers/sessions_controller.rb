# typed: true
# frozen_string_literal: true

# ref: https://github.com/heartcombo/devise/issues/5458#issuecomment-1022555755
class SessionsController < Devise::SessionsController
  def destroy
    super do
      # Turbo requires redirects be :see_other (303); so override Devise default (302)
      return redirect_to(after_sign_out_path_for(resource_name), status: :see_other, notice: I18n.t("devise.sessions.signed_out"))
    end
  end
end
