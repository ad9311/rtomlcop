require_relative '../utils/codes'

class ArrayTableCollection
  include Codes::Offence
  include Codes::Status
  attr_reader :data

  def initialize(line)
    @data = create(line)
  end

  def add_child(line)
    key = line.fetch(:key)
    return if key.nil?

    exists = @data.fetch(:children).include?(key)
    return :bad_code if exists

    @data[:children] << key
  end

  def insp_collection(collection)
    return if collection.empty?

    last = collection.last.data
    related = collection.filter { |tbl| tbl.data.fetch(:path) == last.fetch(:parent) }
    return if related.empty?

    present = related.last.data.fetch(:children).include?(last.fetch(:name))
    return DUP_CHLD if present

    OK
  end

  private

  def create(line)
    {
      lnum: line.fetch(:lnum),
      name: format_table(line)[0],
      parent: format_table(line)[1],
      path: line.fetch(:table).tr('[]', ''),
      children: []
    }
  end

  def format_table(line)
    tbl = line.fetch(:table)
    path = tbl.tr('[]', '').split('.')
    return [path[0], nil] if path.size == 1

    parent = path[0, path.size - 1].join('.')
    [path.last, parent]
  end
end
