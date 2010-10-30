
def factorize(orig)
  factors = {}
  factors.default = 0 # return 0 not nil when missing key
  n = orig
  i = 2
  sqi = 4
  while sqi <= n do
    while n.modulo(i) == 0 do
      n /= i
      factors[i] += 1
    end
    # take advantage of fact that: (i+1)**2 = i**2 + 2*i + 1
    sqi += 2 * i + 1
    i += 1
  end

  if (n != 1) && (n != orig)
    factors[n] += 1
  end
  factors
  
end

puts factorize(600851475143).keys
