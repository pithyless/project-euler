
class Array
  def each_permutation(&blockproc)
    a = []
    self.each do |c|
      a.push(c)
    end
    n = a.length
    p = Array.new(n+1,0)
    i = 1

    blockproc.call(a) 
    
    while i < n do
      if p[i] < i
        j = 0
        j = p[i] if (i % 2) == 1
        t = a[j]
        a[j] = a[i]
        a[i] = t
        p[i] = p[i] + 1
        i = 1
        blockproc.call(a) 
      else
        p[i] = 0
        i = i + 1
      end
    end
  end
end

def solve
  products = {}
  products.default = 0
  "123456789".split(//).each_permutation do |orig|
    orig = orig.join

    i = 1
    while i < 8
      j = 1
      while j + i < 9
        m = orig[0,i].to_i
        n = orig[i,j].to_i
        q = orig[i+j..-1].to_i

        if m * n == q
          products[q] += 1
        end
        j += 1
      end
      i += 1
    end
  end
  products
end

puts solve.keys.inject(:+)
