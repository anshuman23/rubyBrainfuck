#!/usr/bin/ruby
require 'io/console'



$arr = Hash.new(0)
$indexer = 0

def init
  $arr = [0]
  $indexer = 0
end


def op1
  #puts "<"
  if($indexer<=0)
    puts "Seg fault"
  end

  $indexer = $indexer - 1
end


def op2
  #puts ">"
  if($indexer >=(30000-1) )
    puts "Seg fault"
  end

  $indexer = $indexer + 1
end


def subtractor
  $arr[$indexer] = ($arr[$indexer] - 1) 
end


def adder
  $arr[$indexer] = ($arr[$indexer] + 1) 
end

def read
  print $arr[$indexer].chr
end


def write
  input = STDIN.getch
  $arr[$indexer] = input.ord
end


def processIndeces(codeString)

  opening = Array.new
  keeper = Hash.new

  index = 0

  codeString.each_byte do|c|

    if(c.chr == "[")
      opening.push(index)

    elsif(c.chr == "]")

      begin
        
        b = opening.pop
        keeper[b] = index

      rescue
        puts "Error1. Mismatch of [ ] operators"
        return

      end
      
    end

    index = index + 1
  end
  

  if(!(opening.empty?))
    puts "Error2. Mismatch of [ ] operators"

  else return keeper
  end

end




def eval(codeString)

  keeper = processIndeces(codeString)
  counter = 0
  store = Array.new

  
  while(counter< codeString.length)
    # code.each_byte do|c|

    op = codeString[counter]
    

    if(op == "." )
      read
      
    elsif(op == ",")
      write

    elsif(op == "<")
      op1

    elsif(op == ">")
      op2

    elsif(op == "+")
      adder

    elsif(op == "-")
      subtractor
      

    elsif (op == "[")

      if($arr[$indexer] > 0)
        store.push(counter)
        

      else counter = keeper[counter]
        

      end

    elsif (op == "]")
      counter = store.pop - 1
      

    end

    counter = counter + 1

  end

end


def interactor
  print "Interactive BrainFuck interpreter (using Ruby)  c. Anshuman C (2016)

- v 1.0.0

Commands -> 
Type ~ (Spaced out from code) to evaluate.
Type @ (Spaced out from code) to quit. 
Type ^ (Spaced out from code) to reinitialize the values of the BF tape and pointer

Press '&' key to hit ENTER
> "

  codeString = ""

  while(true)

    inputted = STDIN.getch
    puts inputted

    if(inputted == "~")

      begin
        
        eval(codeString)

      rescue
        puts"Error! Aborting... Try again."
        return

      end

      
    elsif(inputted == "@")
      exit

    elsif(inputted == "^")
      init

    else codeString.concat(inputted)

    end

  end

end



interactor
