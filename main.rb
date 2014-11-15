load './cells.rb'

#helpers
def check_colony(colony, cell)
  colony.each do |c|
    if(c.get_x==cell.get_x) && (c.get_y==cell.get_y)
      return false
    else
      return true
    end
  end
end


def check_alive_conditions(cell, duplicate_colony)

  neighbor_count = get_neighbor_count(cell, duplicate_colony)
  #alive conditions
  if (neighbor_count > 3) || (neighbor_count < 2)
    return false
  else
    return true
  end
end

def get_neighbor_count(cell, duplicate_colony)
    #get neighbors
    neighbor_count = 0
    duplicate_colony.each do |pn|

      nx_range = cell.get_x - pn.get_x

      if(nx_range==1 || nx_range==0 || nx_range==-1)
        ny_range = cell.get_y - pn.get_y
        if (ny_range==1 || ny_range==0 || ny_range==-1)
          neighbor_count += 1
        end
      end

    end

  neighbor_count -= 1 # ignore self

end


def come_alive(cell, duplicate_colony)

    neighbor_count = get_neighbor_count(cell, duplicate_colony)
    neighbor_count += 1
    if(neighbor_count == 3)
      return true
    else
      return false
    end

end

def  get_dead_neighbors(cell, duplicate_colony)
  results = []
  alive = false

  (-1..1).each do |x|
    (-1..1).each do |y|
      resx = cell.get_x - x
      resy = cell.get_y - y

      duplicate_colony.each do |asdf|
        if(asdf.get_x == resx && asdf.get_y == resy)
            alive = true
            break
          end
        end

      if(!alive)
        results << Cell.new(resx, resy)
      end

  end
  end

  return results

end

#main
(
#cell container
colony = []

#initialize some cells
5.times do
  x = Random.rand(0..50)
  y = Random.rand(0..50)

  cell = Cell.new(x,y)
  if(check_colony(colony, cell))
    colony << cell
  else
    redo
  end
end

duplicate_colony = colony.dup

#loop through the colony
colony.each do |cell|

  #check if cell stays alive
  if !check_alive_conditions(cell,duplicate_colony)
    colony.delete(cell)
  end

  #get array of cells neighbors
  ndc = get_dead_neighbors(cell, duplicate_colony) #neighbor dead cell
  ndc.each do |hjkl|
    if(come_alive(hjkl, duplicate_colony) == check_colony(hjkl))
      colony << Cell.new()


end
