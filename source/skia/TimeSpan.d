module skia.TimeSpan;
/// https://dlang.org/phobos/std_datetime.html
import std.format;

struct TimeSpan
{
    const long TicksPerDay = 864000000000L;

	const long TicksPerHour = 36000000000L;

	const long TicksPerMinute = 600000000L;

	const long TicksPerSecond = 10000000L;

    const long TicksPerMillisecond = 10000L;

    private long _ticks;
    long Ticks() { return _ticks; }

    private int _days;
    int Days() { return _days; }

    private int _hours;
    int Hours() { return _hours; }

    private int _minutes;
    int Minutes() { return _minutes; }

    private int _seconds;
    int Seconds() { return _seconds; }

    private int _milliseconds;
    int Milliseconds() { return _milliseconds; }

    private double _totalDays;
    double TotalDays() { return _totalDays; }

    private double _totalHours;
    double TotalHours() { return _totalHours; }

    private double _totalMinutes;
    double TotalMinutes() { return _totalMinutes; }

    private double _totalSeconds;
    double TotalSeconds() { return _totalSeconds; }

    private double _totalMilliseconds;
    double TotalMilliseconds() { return _totalMilliseconds; }

    this(int hours, int minutes, int seconds) 
    {
        this._ticks = cast(long)hours*TicksPerHour + 
                      cast(long)minutes*TicksPerMinute + 
                      cast(long)seconds*TicksPerSecond;

        this.initProperty();
    }

    this(int days, int hours, int minutes, int seconds) 
    {
        this._ticks = cast(long)days*TicksPerDay + 
                      cast(long)hours*TicksPerHour + 
                      cast(long)minutes*TicksPerMinute + 
                      cast(long)seconds*TicksPerSecond;

        this.initProperty();
    }

    this(int days, int hours, int minutes, int seconds, int milliseconds)
    {
        this._ticks = cast(long)days*TicksPerDay + 
                      cast(long)hours*TicksPerHour + 
                      cast(long)minutes*TicksPerMinute + 
                      cast(long)seconds*TicksPerSecond + 
                      cast(long)milliseconds*TicksPerMillisecond;

        this.initProperty();
    }

	this(long ticks)
    {
        this._ticks = ticks;
        this.initProperty();
    }

    private void initProperty() 
    {
        double t = cast(double)_ticks;
        // total
        this._totalDays = t/cast(double)TicksPerDay;
        this._totalHours = t/cast(double)TicksPerHour;
        this._totalMinutes = t/cast(double)TicksPerMinute;
        this._totalSeconds = t/cast(double)TicksPerSecond;
        this._totalMilliseconds = t/cast(double)TicksPerMillisecond;
        // single
        this._days = cast(int)_totalDays;
        this._hours = cast(int)_totalHours % 24;
        this._minutes = cast(int)_totalMinutes % 60;
        this._seconds = cast(int)_totalSeconds % 60;
        this._milliseconds = cast(int)(_totalMilliseconds - cast(long)_seconds*TicksPerMillisecond);
    }

    static TimeSpan Zero() 
    {
        TimeSpan s;
        return s;
    }

	TimeSpan Add(TimeSpan ts)
    {
        TimeSpan s;
        s._ticks = this._ticks + ts._ticks;
        s.initProperty();
        return s;
    }
    
    static int Compare(TimeSpan t1, TimeSpan t2)
    {
        auto space = t1._ticks - t2._ticks;
        if (space > 0) {
            return 1;
        }
        if (space == 0) {
            return 0;
        }
        return -1;
    }

    int CompareTo(TimeSpan ts)
    {
        auto space = this._ticks - ts._ticks;
        if (space > 0) {
            return 1;
        }
        if (space == 0) {
            return 0;
        }
        return -1;
    }

    // 获取TimeSpan的绝对值
    TimeSpan Duration()
    {
        TimeSpan s = this;
        if (s._ticks < 0) {
            s._ticks = -s._ticks;
        }
        s.initProperty();
        return s;
    }
    /// 获取TimeSpan的相反数
    TimeSpan Negate()
    {
        TimeSpan s = this;
        s._ticks = -s._ticks;
        s.initProperty();
        return s;
    }

    /// Equal
    bool Equals(TimeSpan ts)
    {
        return this._ticks == ts._ticks;
    }

    static bool Equals(TimeSpan t1, TimeSpan t2)
    {
        return t1._ticks == t2._ticks;
    }


    /// From
	static TimeSpan FromDays(double value)
    {
        TimeSpan s;
        auto t = cast(double)s.TicksPerDay;
        s._ticks = cast(long)(t*value); 
        s.initProperty();
        return s;
    }

	static TimeSpan FromHours(double value)
    {
        TimeSpan s;
        auto t = cast(double)s.TicksPerHour;
        s._ticks = cast(long)(t*value);
        s.initProperty();
        return s;
    }

	static TimeSpan FromMinutes(double value)
    {
        TimeSpan s;
        auto t = cast(double)s.TicksPerMinute;
        s._ticks = cast(long)(t*value);
        s.initProperty();
        return s;
    }

	static TimeSpan FromSeconds(double value)
    {
        TimeSpan s;
        auto t = cast(double)s.TicksPerSecond;
        s._ticks = cast(long)(t*value);
        s.initProperty();
        return s;
    }

    static TimeSpan FromMilliseconds(double value)
    {
        TimeSpan s;
        auto t = cast(double)s.TicksPerMillisecond;
        s._ticks = cast(long)(t*value);
        s.initProperty();
        return s;
    }

	static TimeSpan From_ticks(long value)
    {
        TimeSpan s;
        s._ticks = value;
        s.initProperty();
        return s;
    }

    TimeSpan opBinary(string op)(TimeSpan ts) if(op == "+" || op == "-")
    {
        TimeSpan s;
        if (op == "+")  {
            s._ticks = this._ticks + ts._ticks;
        } else {
            s._ticks = this._ticks - ts._ticks;
        }
        s.initProperty();
        return s;
    }

    static TimeSpan opBinary(string op)(TimeSpan t1, TimeSpan t2) if(op == "+" || op == "-")
    {
        TimeSpan s;
        if (op == "+")  {
            s._ticks = t1._ticks + t2._ticks;
        } else {
            s._ticks = t1._ticks - t2._ticks;
        }
        s.initProperty();
        return s;
    }

    /**
        /// operate "==" | "!=" => opCmp
        static bool opBinary(string op)(TimeSpan t1, TimeSpan t2) if(op == "==" || op == "!=")
        {
            switch (op)
            {
                case "==":
                    return t1._ticks == t2._ticks;
                    break;
                case "!=":
                    return t1._ticks != t2._ticks;
                    break;
                default:
                    return true;
                    break;
            }
        }
     */

    long opCmp(const ref TimeSpan ts) const
    {
      return (_ticks == ts._ticks ? (ts._ticks - _ticks) : _ticks - ts._ticks);
    }

    /// 1.02:03:10.0200000
    string ToString()
    {
        auto ms = cast(long)Milliseconds;
        ms = ms * TicksPerMillisecond;
        string l = format("%07d", ms);

        string d = format("%d", _days);
        string h = format("%02d", _hours);
        string m = format("%02d", _minutes);
        string s = format("%02d", _seconds);
        return d ~"."~ h ~":"~ m ~":"~ s ~"."~ l;
    }

    /// 字符串转TimeSpan
    // static bool TryParse (string input, IFormatProvider formatProvider, out TimeSpan result)
    static bool TryParse (string input, string formatProvider, inout TimeSpan result)
    {
        return true;
    }
}