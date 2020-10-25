class Flowchart
{
  ArrayQueue elements;
  
  Flowchart()
  {
    elements = new ArrayQueue();
  }
  
  void add(String command)
  {
    // add command
    elements.enqueue(command);
  }
  
  void ifStatement(String condition, String true_cmd, String false_cmd)
  {
    elements.enqueue(condition, true_cmd, false_cmd);
  }
  
  void ifStatement(String condition, String[] true_cmd,String[] false_cmd)
  {
    elements.enqueue(condition, true_cmd, false_cmd);
  }
  
  void render()
  {
    // show all elements in flowchart
    for(int i=0; i< elements.getSize(); i++)
    {
      println(elements.getValue(i));
    }
  }
  
  String getFlowchart()
  {
    return elements.dequeue();
  }

  int getSize()
  {
    return elements.getSize();
  }
}

class ArrayQueue
{
  StringList queue;
  
  ArrayQueue()
  {
    queue = new StringList();
  }
  
  int getSize()
  {
    return queue.size();
  }
  
  String getValue(int index)
  {
    return queue.get(index);
  }
  
  String dequeue()
  {
    // remove an item from the queue (front)
    return queue.remove(0);
  }
  
  void enqueue(String item)
  {
    // add an item to the queue (rear)
    queue.append(item);
  }
  
  void enqueue(String if_condition, String true_cmd, String false_cmd)
  {
    queue.append("[" + if_condition + "," + true_cmd + "," + false_cmd + "]");
  }
  
  void enqueue(String if_condition, String[] true_cmd, String[] false_cmd)
  {
    String true_statement = "", false_statement = "";
    
    for(int i=0; i<true_cmd.length; i++)
    {
      if(i == 0)
      {
        true_statement += true_cmd[i];
      }
      else
      {
        true_statement += "+" + true_cmd[i];
      }
    }
    
    for(int j=0; j<false_cmd.length; j++)
    {
      if(j == 0)
      {
        false_statement += false_cmd[j];
      }
      else
      {
        false_statement += "+" + false_cmd[j];
      }
    }
    
    queue.append("[" + if_condition + "," + true_statement + "," + false_statement + "]");
  }
}
