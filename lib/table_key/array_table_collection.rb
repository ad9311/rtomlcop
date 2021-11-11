class ArrayTableCollection
  attr_reader :array_table

  def initialize(line)
    @array_table = create(line)
  end

  def add_child(line)
    key = line.fetch(:key)
    return if key.nil?

    exists = @array_table.fetch(:children).include?(key)
    return :bad_code if exists
    @array_table[:children] << key
  end

  private

  def create(line)
    {
      lnum: line.fetch(:lnum),
      name: extract_root(line),
      path: line.fetch(:table).tr('[]', ''),
      children: []
    }
  end

  def extract_root(line)
    tbl = line.fetch(:table)
    name = tbl.tr('[]', '').split('.')
    return name[0] if name.size == 1

    name[1, name.size - 1].join('.')
  end
end