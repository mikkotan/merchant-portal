class RenameActivePipelinesToPipelines < ActiveRecord::Migration[7.1]
  def change
    rename_table :active_pipelines, :pipelines
  end
end
