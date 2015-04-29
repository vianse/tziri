class CheckinsController < ApplicationController
  before_action :set_checkin, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  def validacion
        phone_number = params["phone_number"]
        code = params["code"] 
        email = Verification.where(phone_number: phone_number, code: code).pluck(:movil).first
        evento = Verification.where(phone_number: phone_number, code: code).pluck(:codigo_evento).first
        verification = Verification.where(phone_number: phone_number, code: code).first
        if verification
           verification.destroy
            check = Checkin.where(:correo => email, :codigo_evento => evento).first
            check.update(:nombre_evento => 1)
            #render status: 200, json: {verified: true}.to_json
            redirect_to :action => 'gracias'
             
        else
            render status: 200, json: {verified: false}.to_json
            #redirect_to :controller => 'home', :action => 'index'
        end
  end

  def error

  end

  def compro

  end

  def gracias

  end


  def index
    @name = Profile.where(:user_id.to_s => current_user.id.to_s).count
    if @name != 0 
     @checkins = Checkin.all
    else
     redirect_to :controller => 'profiles', :action => 'new'
    
    end
  end

  def show
    respond_with(@checkin)
  end

  def new
    @nombre = Profile.where(:user_id.to_s => current_user.id.to_s).pluck(:nombre).first
    @puesto = Profile.where(:user_id.to_s => current_user.id.to_s).pluck(:puesto).first
    @email = User.where(:id => current_user.id).pluck(:email).first

    @checkin = Checkin.new
    respond_with(@checkin)
  end

  def edit
  end

  def create
    @codigo = params[:codigo_evento] 
    @evento_id = Evento.where(:codigo => params[:codigo_evento]).pluck(:id).first
    logger.debug @evento_id

      #@checkin = Checkin.new(checkin_params)
      #@checkin.save
      #respond_with(@checkin)

    #### valida si existe el evento.
    @valida = Evento.where(:codigo => params[:codigo_evento]).count
   if @valida != 0
     #--Primer Condición -- "El valor es igual a 1, entonces valida que exista el checkin, con el parametro 1
     #render status: 200, json: {existe: true}.to_json
     #--Segunda Condición -- Valida que exista un checkin con valor 2
     @verifica = Checkin.where(:codigo_evento => params[:codigo_evento] , :correo => current_user.email, :nombre_evento => "2").count
    if @verifica != 0
     #Si el valor es mayor a 1 
     #render status: 200, json: {existe: true}.to_json
       redirect_to :action => 'error', :event => params[:codigo_evento]
    else @verifica.nil?
     #Si el checkin no existe, se crea
       @verifica1 = Checkin.where(:codigo_evento => params[:codigo_evento] , :correo => current_user.email, :nombre_evento => "1").count
    if @verifica1 == 1
        #verifica si el checkin tiene el valor 1
        redirect_to :action => 'compro'
     else
        #si no tiene el valor 1, crea el checkin
        
        @checkin = Checkin.create({
        :codigo_evento => params[:codigo_evento], 
        :nombre => params[:nombre],
        :puesto => params[:puesto],
        :correo => params[:correo],
        :nombre_evento => params[:nombre_evento],
        :evento_id => @evento_id
        });
        @checkin.save
        #redirect_to :controller => 'verifications', :action => 'generate_code', :phone_number => '+525548225097', :type => 'post'
        @telefono = Profile.where(:user_id.to_s => current_user.id.to_s).pluck(:movil)
        phone_number = @telefono.to_s
        code = Random.rand(10000..99999).to_s
        Verification.create(phone_number: phone_number, code: code, movil: params[:correo], codigo_evento: params[:codigo_evento] )
        SinchSms.send('53c3f2a5-23e6-400c-8b56-442b67e7f442', '4i7JtsBJsEqex9B6W49+YA==', "Access code #{code}", phone_number)
        #render status: 200, nothing: true
        redirect_to :action => 'error'
        #render status: 200, json: {existe: false}.to_json
      end
    end
    else 
    #-- Primera condición -- "El Valor es igual a 0
     redirect_to :action => 'no_existe'
     #render status: 200, json: {existe: false}.to_json
   end  
    
  end

  def no_existe
    
  end

  def update
    @checkin.update(checkin_params)
    respond_with(@checkin)
  end

  def destroy
    @checkin.destroy
    respond_with(@checkin)
  end

  private
    def set_checkin
      @checkin = Checkin.find(params[:id])
    end

    def checkin_params
      params.require(:checkin).permit(:codigo_evento, :nombre, :puesto, :correo)
    end
end
