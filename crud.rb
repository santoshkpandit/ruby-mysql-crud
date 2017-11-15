require 'mysql'

class MysqlDatabase

  def initialize(host,dbname,dbuser,dbpassword)
    @host       = host
    @dbname     = dbname
    @dbuser     = dbuser
    @dbpassword = dbpassword
  end

  def connect
    puts('connecting to mysql host..')
    mysql = Mysql.connect(@host, @dbuser, @dbpassword, @dbname)
    puts('connected')
    mysql.close()
  end

  def insert_data
    puts('connecting to mysql host..')
    mysql = Mysql.connect(@host, @dbuser, @dbpassword, @dbname)
    puts('connected..')

    puts('inserting 5 data...')
    stmt = mysql.prepare('insert into product(name,price,created) values (?,?,now())')

    i = 1
    while i<=5
      stmt.execute "product #{i}",0.26*i
      i += 1
    end
    puts('done')
    mysql.close()
  end

  def read_data
    puts('connecting to mysql host..')
    mysql = Mysql.connect(@host, @dbuser, @dbpassword, @dbname)
    puts('connected..')

    puts('retrieving all data')
    puts('---------------------------------------->')
    results = mysql.query('select id,name,price,created from product')
    results.each do |id,name,price,created|
      puts("#{id}\t #{name}\t #{price}\t #{created}")
    end
    mysql.close()

  end

  def update_data(id)
    puts('connecting to mysql host..')
    mysql = Mysql.connect(@host, @dbuser, @dbpassword, @dbname)
    puts('connected')

    puts("updating data id #{id}")
    stmt = mysql.prepare('update product set name=?,price=? where id=?')
    # you can change these values
    stmt.execute 'product-updated',0.75,id
    puts('done')
    mysql.close()
  end

  def delete_data(id)
    puts('connecting to mysql host..')
    mysql = Mysql.connect(@host, @dbuser, @dbpassword, @dbname)
    puts('connected')

    puts("deleting data id #{id}")
    stmt = mysql.prepare('delete from product where id=?')
    stmt.execute id
    puts('done')
    mysql.close()
  end

end

# change database configuration
 dbObj = MysqlDatabase.new('127.0.0.1','help','root','')
 dbObj.connect()
 dbObj.insert_data()
 dbObj.read_data()
 dbObj.update_data(1)
 dbObj.delete_data(2) 