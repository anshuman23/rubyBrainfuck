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
   # global indexer
  if($indexer<=0)
    puts "Seg fault"
    
  end

 $indexer = $indexer - 1

end

def op2
  #puts ">"
    #global indexer
 if($indexer >=(30000-1) )
   puts "Seg fault"
   
  end

  $indexer = $indexer + 1
  
end

def subtractor
 # puts"in subtrctr"
  #global indexer
  #if($arr[$indexer] >= 1)
   # $arr[$indexer] = $arr[$indexer] - 1

 # else $arr[$indexer] = 255

  $arr[$indexer] = ($arr[$indexer] - 1) % 256
#print $arr[$indexer]  
  #end
end

def adder
  #puts "in adder"
  #global indexer

  #if($arr[$indexer] <= 254 )
   # $arr[$indexer] = $arr[$indexer] + 1

  #else $arr[$indexer] = 0
  # end
  $arr[$indexer] = ($arr[$indexer] + 1) % 256
 # print $arr[$indexer]
end

def read
#puts "in read"
  #global indexer
  print $arr[$indexer].chr
  
end

def write
#puts "in write"  
 # global indexer
  input = STDIN.getch
  if( (input.ord) != 26 )
    $arr[$indexer] = input.ord
  end
end

def parse(code)

  opening = Array.new
  loop = Hash.new

  index = 0

  code.each_byte do|c|

    if(c.chr == "[")
      opening.push(index)

    elsif(c.chr == "]")

      begin
      
      b = opening.pop
      loop[b] = index

      rescue
        puts "Error1. Mismatch of [ ] operators"
        return

      end
      
    end

    index = index + 1
  end
  

  if(!(opening.empty?))
    puts "Error2. Mismatch of [ ] operators"

  else return loop
  end

end




def eval(code)

 #global indexer


  
  loop = parse(code)
  

  counter = 0

  store = Array.new

  
  while(counter< code.length)
 # code.each_byte do|c|

    op = code[counter]
    

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
        

      else counter = loop[counter]
       

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

  code = ""

  while(true)

    inputted = STDIN.getch
    puts inputted
        
    
      

    if(inputted == "~")

      # begin
            
      eval(code)

      #rescue
       # puts"Error! Aborting... Try again."
       # return

      #end

    
    elsif(inputted == "@")
      exit

    elsif(inputted == "^")
      init

    else code.concat(inputted)

    end

  end

end
      


#eval("++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.")
    
interactor
