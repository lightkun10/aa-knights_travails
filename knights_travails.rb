require_relative 'tree_node'
# require_relative 'tree_node_2'
require 'byebug'

class KnightPathFinder
    attr_accessor :start_pos, :root_node, :considered_positions

    ## 8 Possible moves
    MOVES = [
        [ 2,  1],
        [ 2, -1],
        [ 1,  2],
        [ 1, -2],
        [-2,  1], 
        [-1,  2],
        [-2, -1],
        [-1, -2]
    ].freeze
    
    def self.valid_moves(pos)
        valid_moves = []
        x, y = pos # [5], [4]
        MOVES.each do |mx, my|
            possible_moves = [mx + x, my + y]
            if possible_moves.all? { |move| move.between?(0, 7) }
                valid_moves << possible_moves
            end
        end

        return valid_moves
    end

    def initialize(start_pos)
        @start_pos = start_pos
        @considered_positions = [start_pos]
        build_move_tree
    end

=begin
    Create an instance method #find_path(end_pos) to search for end_pos in the move tree. 
    You can use either dfs or bfs search methods from the PolyTreeNode exercises; 
        it doesn't matter. This should return the tree node instance containing end_pos.
=end
    # debugger
    def find_path(end_pos)
        # self.dfs(target)
        end_node = root_node.bfs(end_pos)
        trace_path_back(end_node).map { |node| node.value }.reverse!
    end

    def new_move_positions(pos)
        filtered_pos = KnightPathFinder.valid_moves(pos)
                .reject { |new_pos| considered_positions.include?(new_pos) }
        filtered_pos.each { |new_pos| considered_positions << new_pos }
    end

    def trace_path_back(end_node)
        nodes = []

        current_node = end_node
        until current_node.nil?
            nodes.push(current_node)
            current_node = current_node.parent
        end
        nodes
    end

    # debugger
    def build_move_tree
        self.root_node = PolyTreeNode.new(start_pos)

        # build the tree out in breadth-first fashion
        nodes = [root_node]
        
        until nodes.empty?
            current_node = nodes.shift
            current_pos = current_node.value
            
            # explore possibilities of one current position
            new_move_positions(current_pos).each do |next_pos|
                next_node =  PolyTreeNode.new(next_pos)
                current_node.add_child(next_node)
                nodes.push(next_node)
            end
        end
    end
end

if $PROGRAM_NAME == __FILE__
  kpf = KnightPathFinder.new([0, 0])
  p kpf.find_path([7, 6])
end