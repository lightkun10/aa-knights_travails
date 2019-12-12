class PolyTreeNode
    def initialize(value)
        @value, @parent, @children = value, nil, []
    end

    def inspect
        { 'value' => @value, 'parent_value' => @parent.value }.inspect
    end

    def parent
        @parent
    end

    def children
        # We dup to avoid someone inadvertently trying to modify our
        # children directly through the children array. Note that
        # `parent=` works hard to make sure children/parent always match
        # up. We don't trust our users to do this.
        @children.dup
    end

    def value
        @value
    end

    def parent=(parent)
        return if self.parent == parent

        # re-assign the child from the parent first
        if self.parent
            self.parent.children.delete(self)
        end

        @parent = parent
        self.parent.children.push(self) unless self.parent.nil?
    end

    def add_child(child_node)
        # Just reset the child's parent to us!
        child_node.parent = self
    end

    def remove_child(child_node)
        # Thanks for doing all the work, `parent=`!
        if child_node && !self.children.include?(child_node)
            raise "#{child_node.value} is not the child to begin with."
        end

        child_node.parent = nil
    end

    def dfs(target)
        return self if self.value == target
        return nil if self.nil?
        
        self.children.each do |child|
            deep_search = child.dfs(target)
            return deep_search unless deep_search.nil?
        end
        nil
    end

    def bfs(target)

    end

    def bfs(target)
        # self = selene
        # target = isa

       queue =  [self]
       
       until queue.length == 0
            node = queue.shift
            return node if node.value == target
            queue += node.children
       end
       nil
    end

end

################################################

# gerard = PolyTreeNode.new("Gerard")
# lucas = PolyTreeNode.new("Lucas")
# selene = PolyTreeNode.new("Selene")

# jody = PolyTreeNode.new("Jody")
# lucille = PolyTreeNode.new("Lucille")

# lizbeth = PolyTreeNode.new("Lizbeth")
# daryl = PolyTreeNode.new("Daryl")

# isa = PolyTreeNode.new("Isabelle")
# don = PolyTreeNode.new("Donatello")


## connect the bloodline(?)
# gerard.add_child(lucas)
# gerard.add_child(selene)

# lucas.add_child(jody)

# jody.add_child(lucille)

# selene.add_child(lizbeth)
# selene.add_child(daryl)

# lizbeth.add_child(isa)
# lizbeth.add_child(don)

# p selene.bfs(isa)

###############################################

# ashen = PolyTreeNode.new("Ashen")
# brad = PolyTreeNode.new("Brad")
# gehrman = PolyTreeNode.new("Gehrman")
# donna = PolyTreeNode.new("Donna")
# ariandel = PolyTreeNode.new("Ariandel")
# lucy = PolyTreeNode.new("Lucy")
# darth = PolyTreeNode.new("Darth")

# ## connect the bloodline(?)
# ashen.add_child(brad)
# ashen.add_child(gehrman)

# brad.add_child(donna)
# brad.add_child(ariandel)

# gehrman.add_child(lucy)
# gehrman.add_child(darth)

# p brad.dfs(darth)