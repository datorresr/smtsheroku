class SesionesController < ApplicationController
  include SesionesHelper
  def new
  end

  def create
    usuario = Usuario.find_by(email: params[:session][:email].downcase)
    if usuario && usuario.authenticate(params[:session][:password])
      log_in usuario
      #params[:session][:remember_me] == '1' ? remember(usuario) : forget(usuario)
      redirect_back_or usuario
      #redirect_to usuario
      # Log the user in and redirect to the user's show page.
    else
       flash.now[:danger] = 'Email o contraseña incorrecta'
       render 'new'
    end
  end


  def destroy
    log_out
    redirect_to ingresar_path
  end
end
