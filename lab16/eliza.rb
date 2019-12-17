#! /usr/bin/ruby -w

#syntax usage from rubyguides.com 
#for include? start_with?

#Represents a Rogerian psychiatrist
class Shrink

  #initializes 'memory' of Eliza.
  def initialize()
    @he="he"
    @she="she"
    @they="they"
  end

  #read a statement and convert it to a psychiatric response.
  def generateResponse(blather)
    #downcase for ease of substitution
    blather = blather.downcase

    #if patients asks "are you", eliza ask if it is important 
    if blather.include? "are you"
        blather.gsub!(/\bare you\b/, "IS IT IMPORTANT IF I AM")
    end

    #if patient says well or perhaps, eliza does not repeat
    if blather.start_with? "well," 
        blather.sub!(/\bwell, \b/, "")
    end
    if blather.start_with? "perhaps"
        blather.sub!(/\bperhaps \b/, "")
    end

    #if patient uses never or always, eliza asks them to be more specific
    if blather.include? "never" 
        blather = "CAN YOU BE MORE SPECIFIC"
    elsif blather.include? "always"
        blather = "CAN YOU BE MORE SPECIFIC" 
    end

    #she's human!!! patient is sad... feeling weird.. she's there for them
    if blather.include? "i'm sad"
        blather = "THAT'S WHY I AM HERE" 
    end

    #change 'you', 'your', etc. to uppercase 'I', 'MY'
    blather.gsub!(/\byour\b/,"MY")
    blather.gsub!(/\byou\b/,'I')

    blather.gsub!(/\bwas\b/,'were')

    #Replace 'my' with 'your', 'me' with 'you', 'I' with 'you', etc.
    blather.gsub!(/\bmy\b/,"your")
    blather.gsub!(/\bme\b/,"you")
    blather.gsub!(/\bi\b/,'you')

    #Sub in past references, but only for the 1st occurrence or it looks weird
    blather.sub!(/\b(he|him)\b/, @he)
    blather.sub!(/\b(she|her)\b/, @she)
    blather.sub!(/\b(they|them)\b/, @they)


    #Get future references -- note that these do NOT change the immediate output
    hePat=/.*\b(your (father|brother|(ex-?)?(husband|boyfriend)))\b.*/
    shePat = /.*\b(your (mother|sister|(ex-?)?(wife|girlfriend)))\b.*/
    @he=blather.sub(hePat, '\1').chomp if blather =~ hePat 
    @she=blather.sub(shePat, '\1').chomp if blather =~ shePat

    #Deal with name
    namePat=/.*\byour name is (\w+).*/
    @name=blather.sub(namePat,'\1')
    blather.sub!(namePat,'nice to meet you, \1.  How can I help you')

    #results are uppercased, for aesthetics.
    return blather.upcase + "?"
  end
end


#main -- reads from standard input unless -test is the first parameter.
eliza = Shrink.new()
if ARGV[0] == "-test"
    ['My girlfriend never listens to me',
     "I think she might be deaf",
     "yes",
     "I am afraid of clowns",
     "Well, they just seem creepy",
     "Also, when I was a kid, a clown killed my dad",
      "Are you a clown in disguise?",
      "I'm sad",
    ].each do |stmt|
        puts stmt
        puts eliza.generateResponse(stmt)
    end
else
  while line = gets
    response = eliza.generateResponse line
    puts response
  end
end