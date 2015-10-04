class Api::NotesController < ApplicationController

  def index
    recipe_id = params[:recipe_id]
    recipe = Recipe.find(recipe_id)
    recipe_notes = recipe.notes

    render json: {notes: recipe_notes}
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

end

{
  note: {
    text: '',
    recipe_id: 1
  }
}
