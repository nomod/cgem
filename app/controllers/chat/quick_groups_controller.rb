module Chat

  class QuickGroupsController < ApplicationController

    def index

      @groups = QuickGroup.all.order(:id)

    end


    def new
      @new_group = QuickGroup.new
    end

    def create

      if params[:quick_group_btn]

        @new_group = QuickGroup.find_by_quick_group_name(params[:quick_group][:quick_group_name])
        #если в базе уже есть такая группа
        if @new_group
          @new_group = QuickGroup.new
          flash[:error] = 'Такое название у группы уже есть!'
          render 'chat/quick_groups/new'
          #если нет, то создаем
        else
          @new_group = QuickGroup.new(new_group)
          if @new_group.save
            flash[:success] = 'Новая группа создана!'
            redirect_to quick_groups_path
          else
            @group_name = params[:quick_group][:quick_group_name]
            render 'chat/quick_groupsnew'
          end
        end

      else

        @groups = QuickGroup.all.order(:id)
        respond_to do |format|
          format.json { render json: {groups: @groups} }
        end

      end

    end


    def edit

      @group = QuickGroup.find_by_id(params[:id])

    end

    def update

      @group = QuickGroup.find_by_id(params[:id])
      if @group.update_attributes(new_group)
        flash[:success] = 'Название группы обновлено!'
        redirect_to quick_groups_path
      else
        render 'edit'
      end

    end

    def destroy

      @group = QuickGroup.find_by_id(params[:id])

      if @group.destroy
        flash[:notice] = "Группа '#{@group.quick_group_name}' удалена!"
        redirect_to quick_groups_path
      else
        redirect_to @group
      end
    end


    private

    def new_group
      params.require(:quick_group).permit(:quick_group_name)
    end

  end

end