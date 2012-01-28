# encoding: utf-8
class Admin::UnauthorizedNamesController < ApplicationController

  before_filter :has_UN_privileges

  def index
    @title = "Tous les noms interdits"
    @unauthorized_names = Admin::UnauthorizedName.all
  end

  def show
    @unauthorized_name = Admin::UnauthorizedName.find(params[:id])
    @title = "Nom interdit : #{@unauthorized_name.name}"
  end

  def new
    @unauthorized_name = Admin::UnauthorizedName.new
    @title = "Nouveau nom interdit"
  end

  def create
    @unauthorized_name = Admin::UnauthorizedName.new(params[:admin_unauthorized_name])
    if @unauthorized_name.save
      flash[:success] = "Nom interdit enregistré"
      redirect_to @unauthorized_name
    else
      @title = "Nouveau nom interdit"
      render 'new'
    end
  end

  def edit
    @unauthorized_name = Admin::UnauthorizedName.find(params[:id])
    @title = "Modifier le nom interdit #{@unauthorized_name.name}"
  end

   def update
     @unauthorized_name = Admin::UnauthorizedName.find(params[:id])
     if @unauthorized_name.update_attributes(params[:admin_unauthorized_name])
       flash[:success] = "Nom interdit mis à jour"
       redirect_to @unauthorized_name
     else
       @title = "Modifier le nom interdit #{@unauthorized_name.name}"
       render 'new'
     end
   end

   def destroy
     @unauthorized_name = Admin::UnauthorizedName.find(params[:id])
     @unauthorized_name.destroy
     flash[:success] = "Nom interdit supprimé"
     redirect_to admin_unauthorized_names_path
   end

  private

    def has_UN_privileges
      if signed_in?
        if privileges[:unauthorized_names] != true
          flash[:error] = "Tu n'as pas les droits sur cette ressource"
          redirect_to root_path
        end
      else
        deny_access
      end
    end

end
