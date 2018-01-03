class RemoveCollaboratorIdFromWikiAndUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :wikis, :collaborator_id, :integer
    remove_column :users, :collaborator_id, :integer
  end
end
