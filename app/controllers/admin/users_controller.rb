class Admin::UsersController < Admin::BaseController
  before_filter :load_user_account, :only => [:update, :edit, :destroy, :projects]
  before_filter :load_new_user_account, :only => [:new, :create]

  def index
    @users = User.all
  end

  def new
  end

  def create
    @user.update_attributes(params[:user])
    if @user.save
      flash[:notice] = t(:user_created_successfully)
      redirect_to admin_users_path
    else
      flash[:error] = t(:user_created_unsuccessfully)
      redirect_to new_admin_user_path
    end
  end

  def edit
  end

  def update

    if params[:user]["locked"] == "1" && !@user.locked_at?
      @user.lock_access!
    elsif params[:user]["locked"] == "0" && @user.locked_at?
      @user.unlock_access!
    end

    @user.update_attributes(params[:user])
    if @user.save
      flash[:notice] = "Updated successfully"
      redirect_to user_path(@user)
    else
      flash[:error] = t(:user_updated_unsuccessfully)
      redirect_to edit_admin_user_path(@user)
    end
  end

  def projects
    if request.post?
      params[:project].each do |key, value|
        project = Project.find(key.to_i)
        role = value.to_sym
        @user.has_no_roles_for!(project)
        @user.has_role!(role, project) unless role == :no_access
      end
    end
  end

private

  def load_user_account
    @user = User.find(params[:id])
  end

  def load_new_user_account
    @user = User.new
  end
end
