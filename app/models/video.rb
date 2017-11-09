class Video < ApplicationRecord
  mount_uploader :video_source, VideoUploader # Tells rails to use this uploader for this model.
  belongs_to :concurso
  #after_create :run_workers

  validates :nombre, presence: true
  validates :apellido, presence: true
  validates :email, presence: true
  validates :titulo, presence: true
  validates :descripcion, presence: true
  validates :convirtiendo, :presence => false
  validates :estado, :presence => false
  validates :concurso_id, :presence => true

  private

  def run_workers
    Mp4VideoConverter.perform_async(self.id)
  end
end
