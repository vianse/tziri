class EventosController < ApplicationController
  before_action :set_evento, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def exitoso
    @e = params[:code]
    @evento = Evento.where(:codigo => @e).pluck(:nombre).first
    @numero = Evento.where(:codigo => @e).pluck(:codigo).first
    logger.debug "Prueba #{@e}"
  end

  def index
    @name = Profile.where(:user_id.to_s => current_user.id.to_s).count
    if @name != 0 
     @eventos = Evento.all
    else
     redirect_to :controller => 'profiles', :action => 'new'
    end
  end

  def show
    respond_with(@evento)
  end

  def new
    @eventos = Evento.where(:user_id.to_s => current_user.id.to_s)
    @codigo = Random.rand(100000..999999).to_s
    @evento = Evento.new
    respond_with(@evento)
  end

  def edit
  end

  def create
    # @evento = Evento.new(evento_params)
    # @evento.save
    @evento = Evento.create({
    :nombre => params[:name], 
    :codigo => params[:code],
    :user_id => current_user.id
    });
    @evento.save

    redirect_to  :action => 'exitoso', :code => params[:code]
  end

  def update
    @evento.update(evento_params)
    respond_with(@evento)
  end

  def destroy
    @evento.destroy
    respond_with(@evento)
  end

  private
    def set_evento
      @evento = Evento.find(params[:id])
    end

    def evento_params
      params.require(:evento).permit(:nombre, :codigo)
    end
end
