module Dashboard
  class ProfilesController < Dashboard::BaseController
    def show
      prepare_social_links
    end
    def update
       respond_to do |format|
         if current_user.update_attributes(profile_params)
           format.html { redirect_to dashboard_profile_path, notice: t('notifications.profile_updated_successfully') }
         else
           flash[:alert] = current_user.errors.full_messages
           prepare_social_links
           format.html { render :show }
         end
       end
    end

    def update_password
      respond_to do |format|
        if current_user.update_with_password(profile_params)
          format.html { redirect_to dashboard_profile_path, notice: t('notifications.password_updated_successfully') }
        else
          flash[:alert] = current_user.errors.full_messages
          format.html { render :show }
        end
      end
    end

    private
    def profile_params
      params.require(:user).permit(:name, :avatar, :handle, :phone, :about, :password,
                                   :current_password, :password_confirmation,
                                   social_links_attributes: [:name, :url, :id, '_destroy'])
    end

    def prepare_social_links
      @social_links_map = current_user.social_links.inject({}){|hash, link| hash[link.name] = link; hash}
    end

  end
end
