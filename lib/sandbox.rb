def zzz(a, &dd)
  return "No block given" unless block_given?
  dd.call
  # yield
end

call_miko = ->(p) {p.times {print "mikooo!"}; puts}

zzz(2) {puts "sobbaaa"}
zzz(2){ call_miko.call(2)}


my_proc = Proc.new { puts "proc called" }
my_proc.call