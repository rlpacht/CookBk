class Api::NotesController < ApplicationController

  # TODO: Figure out how to make Ember request this route
  def index
    ids = params[:ids]
    notes = Note.where(id: ids)
    render json: {notes: notes}
  end

  def create
    note_text = params[:note][:text]
    recipe_id = params[:note][:recipe_id]

    note = Note.create({
          text: note_text,
          recipe_id: recipe_id,
          user_id: current_user.id
          })

    render json: {note: note}
  end

  def update
    note_id = params[:id]
    text = params[:note][:text]
    note = Note.find(note_id)
    note.update(text: text)
    render json: {note: note}
  end

  def destroy
    Note.delete(params[:id])
    render json: {}
  end

  def show
    note = Note.find(params[:id])
    render json: {note: note}
  end

end
