class StatesController < ApplicationController
  before_action :set_state, only: [:show, :edit, :update, :destroy]
  before_filter :admin

  def index
    @states = State.all
    @user = current_user
  end

  def show
    
  end

  def new
    @state = State.new
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def create
    @state = State.new(state_params)

    respond_to do |format|
      if @state.save
        format.html { redirect_to @state, notice: 'State was successfully created.' }
        format.json { render :show, status: :created, location: @state }
      else
        format.html { render :new }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @state.update(state_params)
        format.html { redirect_to @state, notice: 'State was successfully updated.' }
        format.json { render :show, status: :ok, location: @state }
      else
        format.html { render :edit }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @state.destroy
    respond_to do |format|
      format.html { redirect_to states_url, notice: 'State was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_state
      @state = State.find(params[:id])
    end

    def state_params
      params.require(:state).permit(:country_id, :name)
    end

    def admin
      @user = current_user
     unless current_user && User.find_by(email: "job4allteam@gmail.com") == current_user
      flash[:alert] = 'Access denied..! Please login as admin.'
      redirect_to root_path
     end
    end
end
