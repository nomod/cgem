module Chat

  class QuickPhrasesController < ApplicationController

    def index

      @phrases = QuickPhrase.all.order(:id)

    end

    def new
      @new_phrase = QuickPhrase.new
      @groups = QuickGroup.all.order(:id)
    end

    def create

      if params[:quick_phrase_btn]

        @new_phrase = QuickPhrase.find_by_phrase(params[:quick_phrase][:phrase])
        #если в базе уже есть такая фраза
        if @new_phrase
          @new_phrase = QuickPhrase.new
          flash[:error] = 'Такая фраза уже есть!'
          render 'chat/quick_phrases/new'
        #если нет, то создаем
        else
          @new_phrase = QuickPhrase.new(new_phrase)
          if @new_phrase.save
            flash[:success] = 'Новая фраза создана!'
            redirect_to quick_phrases_path
          else
            @phrase = params[:quick_phrase][:phrase]
            render 'chat/quick_phrases/new'
          end
        end

      else

        @phrases = QuickPhrase.all.where(quick_group_id: params[:group_id]).order(:id)
        respond_to do |format|
          format.json { render json: {phrases: @phrases} }
        end

      end

    end

    def edit

      @phrase = QuickPhrase.find_by_id(params[:id])
      @groups = QuickGroup.all.order(:id)

    end

    def update

      @phrase = QuickPhrase.find_by_id(params[:id])
      if @phrase.update_attributes(new_phrase)
        flash[:success] = 'Фраза обновлена!'
        redirect_to quick_phrases_path
      else
        render 'edit'
      end

    end

    def destroy

      @phrase = QuickPhrase.find_by_id(params[:id])

      if @phrase.destroy
        flash[:notice] = 'Фраза удалена!'
        redirect_to quick_phrases_path
      else
        redirect_to @phrase
      end
    end

    private

    def new_phrase
      params.require(:quick_phrase).permit(:phrase, :quick_group_id)
    end

  end

end