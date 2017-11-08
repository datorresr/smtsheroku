class Video < OceanDynamo::Table

  dynamo_schema(
      :id,                   # The name of the hash key attribute
      read_capacity_units: 5,                # Used only when creating a table
      write_capacity_units: 5,                # Used only when creating a table
      connect: :late,                         # true, :late, nil/false
      create: true,                          # If true, create the table if nonexistent
      timestamps: [:created_at, :updated_at]  # A two-element array of timestamp columns, or nil/false
    ) do
    attribute :nombre,        :string
    attribute :apellido,      :string
    attribute :email,         :string
    attribute :titulo,        :string
    attribute :descripcion,   :string
    attribute :video_source,  :string
    attribute :estado,        :boolean,    default: false    
  end
  belongs_to :concurso, composite_key: true

end
