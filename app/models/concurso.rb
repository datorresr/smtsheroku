class Concurso < OceanDynamo::Table

  dynamo_schema(
      :id,                   # The name of the hash key attribute
      read_capacity_units: 5,                # Used only when creating a table
      write_capacity_units: 5,                # Used only when creating a table
      connect: :late,                         # true, :late, nil/false
      create: true,                          # If true, create the table if nonexistent
      timestamps: [:created_at, :updated_at]  # A two-element array of timestamp columns, or nil/false
    ) do
    attribute :nombre,        :string
    attribute :imagen,        :string
    attribute :url,           :string
    attribute :fechaInicio,   :datetime
    attribute :fechaFin,      :datetime
    attribute :descripcion,   :string  
  end
  belongs_to :usuario
  has_many :videos, dependent: :destroy

end
