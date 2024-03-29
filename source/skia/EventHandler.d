module skia.EventHandler;

import std.concurrency:initOnce;

import std.algorithm;
import std.container;
import std.range;
import std.signals;


//
// Summary:
//     Represents the method that will handle an event when the event provides data.
//
// Parameters:
//   sender:
//     The source of the event.
//
//   e:
//     An object that contains the event data.
//
// Type parameters:
//   TEventArgs:
//     The type of the event data generated by the event.
struct EventHandler(T...) 
{
    alias void delegate(Object sender, T args) HandlerDelegate; 

	mixin Signal!(Object, T);

	void opCall(Object sender, T args)
	{
		synchronized
		{
			emit(sender, args);
		}
	}

    ref EventHandler!(T) opOpAssign(string op, HandlerDelegate)(HandlerDelegate handler)
        if(op == "+" || op == "-" )
    {
        // BUG: Can't connect delegate which is defined in a function.
        static if(op == "+")
            connect(handler);
        else static if(op == "-")
            disconnect(handler);
        else
            assert(0, op ~ "is not suppported.");
        return this;
    }
}

unittest
{
    class Observer
    {
        EventHandlerTester tester;
        int counter;

        this()
        {
            tester = new EventHandlerTester();
            tester.onClick.connect(&watch01);
            tester.onClick += &watch02;
            tester.onMove += &watch03;
            counter=0;
        }

        void watch01(Object obj, string msg)
        {
            counter++;
            writeln(counter," running watch01: ", msg);
        }

        void watch02(Object obj, string msg)
        {
            counter++;
            writeln(counter, " running watch02: ", msg);
        }


        void watch03(Object obj, string msg, int a)
        {
            counter++;
            writeln(counter, " running watch03: ", msg, a);
        }

        void test()
        {
            tester.start();

            counter=0;
            //tester.onClick.disconnect(&watch01); // bug: Invalid memory operation
            //tester.onClick -= &watch02;

            //tester.start();

        }

    }

    class EventHandlerTester
    {
        EventHandler!() onClick1;
        EventHandler!string onClick;
        EventHandler!(string, int) onMove;

        this()
        {
        }

        void start()
        {
            onClick(this, "onClick");
            onMove(this, "Move to ", 20);
        }
    }

    Observer o = new Observer();
    o.test();
}


/**
for function
*/
struct CallbackHandler(T...) 
{
    alias  void function(T args) HandlerFunction; 
	private HandlerFunction[] m_handler;

	void opCall(T args)
	{
		synchronized
		{
            for(int i = 0; i < this.m_handler.length; i++)
				this.m_handler[i](args);
			// emit(args);
		}
	}

    ref CallbackHandler!(T) opOpAssign(string op, HandlerFunction)(HandlerFunction handler)
        if(op == "+" || op == "-" )
    {
        static if(op == "+")
            m_handler ~= handler;
        else static if(op == "-")
        {  
            size_t len = m_handler.length;
            for(size_t i=0; i<len; i++)
            {
                if(m_handler[i] == handler)
                {
                    if(i == len -1)
                        m_handler = m_handler[0..i];
                    else
                        m_handler = m_handler[0..i] ~ m_handler[i+1 .. len];
                    break;
                }
            }
        }
        else
            assert(0, op ~ "is not suppported.");

        return this;
    }
}


/**
the base class for classes containing event data.
*/
class EventArgs
{
    /**
    Represents an event with no event data.
    */
	static EventArgs Empty() {
        __gshared EventArgs inst;
        return initOnce!inst(new EventArgs());
    }

}
