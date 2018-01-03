class AddCollaboratorToWiki < ActiveRecord::Migration[5.1]
  def change
    add_column :wikis, :selected_option, :integer
  end
end
