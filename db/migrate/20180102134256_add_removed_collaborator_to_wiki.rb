class AddRemovedCollaboratorToWiki < ActiveRecord::Migration[5.1]
  def change
    add_column :wikis, :removed_collaborator, :integer
  end
end
