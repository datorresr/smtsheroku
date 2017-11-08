class Usuario < OceanDynamo::Table

  dynamo_schema(
      :id,                   # The name of the hash key attribute
      read_capacity_units: 5,                # Used only when creating a table
      write_capacity_units: 5,                # Used only when creating a table
      connect: :late,                         # true, :late, nil/false
      create: true,                          # If true, create the table if nonexistent
      timestamps: [:created_at, :updated_at]  # A two-element array of timestamp columns, or nil/false
    ) do
    attribute :nombre,          :string
    attribute :apellido,        :string
    attribute :email,           :string
    attribute :password_digest, :string
    attribute :admin,           :boolean,    default: false    
  end
  has_many :concursos, dependent: :destroy

  def feed
    @concursos = Concurso.all
    @cfinals = Array.new
    @concursos.each { |c| s = c.usuario_ids
      s.each do |n|
        if n == id
          @cfinals.push(c)
        end
      end
    }    
    @concursos = @cfinals
    #Concurso.where("usuario_id = ?", id)
  end

  def Usuario.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
 