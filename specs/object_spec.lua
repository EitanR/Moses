_G._ = require 'moses'

context('Object functions specs', function()

  context('identity', function()
  
    test('returns the received value',function()
      assert_equal(_.identity(1),1)
      local v = {x = 0}      
      assert_equal(_.identity(v),v)
      assert_not_equal(v,{x = 0})
    end)
    
  end)
  
  context('once', function()
  
    test('returns a version of a function that runs once',function()
      local sq = _.once(function(a) return a*a end)
      assert_equal(sq(2),4)
    end)
    
    test('successive calls will keep yielding the original answer',function()
      local sq = _.once(function(a) return a*a end)
      for i = 1,10 do
        assert_equal(sq(i),1)
      end
    end)    
    
  end)
  
  context('memoize', function()
  
    local fib_time, fib_value, mfib_time, mfib_value
    local fib, mfib
    
    before(function()
      local function fib(n)
        return n < 2 and n or fib(n-1)+fib(n-2)
      end      
      local mfib = _.memoize(fib)
      fib_time = os.time()*1000
        for i = 1, 1e3 do fib_value = (fib_value or 0)+fib(20) end
      fib_time = os.time()*1000-fib_time
      
      mfib_time = os.time()*1000
        for i = 1, 1e3 do mfib_value = (mfib_value or 0)+mfib(20) end
      mfib_time = os.time()*1000-mfib_time      
    end)
    
    test('memoizes an expensive function by caching its results',function()
      assert_equal(mfib_value,fib_value)
      assert_true(mfib_time<fib_time)
    end)
    
    test('can take a hash function to compute an unique output for multiple args',function()
    
      local function hash(a,b) return (a+b)+((a*1640531513 ^ b*2654435789) % 1e6) end
      local function fact(a) return a <= 1 and 1 or a*fact(a-1) end
      local diffFact = function(a,b) return fact(a)-fact(b) end
      local mdiffFact = _.memoize(function(a,b) return fact(a)-fact(b) end,hash)
      local times, rep = 1e3, 30
      
      local time = os.time()*1000
      for j = 1,times do 
        for ai = 1,rep do
          for aj = 1,rep do diffFact(ai,aj) end
        end
      end
      time = os.time()*1000-time

      local mtime = os.time()*1000
      for j = 1,times do 
        for ai = 1,rep do
          for aj = 1,rep do mdiffFact(ai,aj) end
        end
      end
      mtime = os.time()*1000-mtime  

      assert_true(mtime<time)

    end)
    
    test('is aliased as "cached"',function()
      assert_equal(_.memoize,_.cache)
    end)   
    
  end)  
  
  context('after', function()
  
    test('returns a function that will respond on its count-th call',function()
      local function a(r) return (r) end
      a = _.after(a,5)
      for i = 1,10 do
        if i < 5 then 
          assert_nil(a(i))
        else 
          assert_equal(a(i),i)
        end
      end
    end)
    
  end) 
  
  context('compose', function()
    
    test('can compose commutative functions',function()
      local greet = function(name) return "hi: " .. name end
      local exclaim = function(sentence) return sentence .. "!" end
      assert_equal(_.compose(greet,exclaim)('moe'),'hi: moe!')
      assert_equal(_.compose(exclaim,greet)('moe'),'hi: moe!')
    end)
    
    test('composes mutiple functions',function()
      local function f(x) return x^2 end
      local function g(x) return x+1 end
      local function h(x) return x/2 end
      local compositae = _.compose(f,g,h)
      assert_equal(compositae(10),36)
      assert_equal(compositae(20),121)
    end)    
    
  end) 

  context('wrap', function()
  
    test('wraps a function and passes args',function()
      local greet = function(name) return "hi: " .. name end
      local backwards = _.wrap(greet, function(f,arg)
          return f(arg) ..'\nhi: ' .. arg:reverse()
        end) 
      assert_equal(backwards('john'),'hi: john\nhi: nhoj')
    end)
    
  end)
  
  context('times', function()
  
    test('calls a given function n times',function()
      local f = ('Lua programming'):gmatch('.')
      local r = _.times(3,f)
      assert_true(_.isEqual(r,{'L','u','a'}))
      
      local count = 0
      local function counter() count = count+1 end
      _.times(10,counter)
      assert_equal(count,10)
    end)
    
  end)  
  
  context('bind', function()
  
    test('binds a value to the first arg of a function',function()
      local sqrt2 = _.bind(math.sqrt,2)
      assert_equal(sqrt2(),math.sqrt(2))
    end)
    
  end) 

  context('bindn', function()
  
    test('binds n values to as the n-first args of a function',function()
      local function out(...)
        return table.concat {...}
      end
      out = _.bindn(out,'OutPut',':',' ')
      assert_equal(out(1,2,3),'OutPut: 123')
      assert_equal(out('a','b','c','d'),'OutPut: abcd')
    end)
    
  end)
  
  context('uniqueId', function()
  
    test('returns an unique (for the current session) integer Id',function()
      local ids = {}
      for i = 1,100 do
        local newId = _.uniqueId()
        assert_false(_.include(ids,newId))
        _.push(ids,newId)
      end     
    end)
    
    test('accept a string template to format the returned id',function()
      local ids = {}
      for i = 1,100 do
        local newId = _.uniqueId('ID:%s')
        assert_equal(newId,'ID:'..newId:sub(4))
        assert_false(_.include(ids,newId))
        _.push(ids,newId)
      end        
    end) 
    
    test('is aliased as "uId"',function()
      assert_equal(_.uniqueId,_.uId)
    end)
    
  end)  
  
end)