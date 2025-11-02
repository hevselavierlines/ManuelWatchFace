import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.ActivityMonitor;

class ManuelWatchFaceView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    function minuteToText(num as Number) {
        switch (num) {
            case 0:
                return "";
            case 1:
                return "Ans";
            case 2:
                return "Zwa";
            case 3: 
                return "Drei";
            case 4:
                return "Vier";
            case 5:
                return "Fünf";
            case 6:
                return "Sechs";
            case 7:
                return "Siebn";
            case 8:
                return "Ocht";
            case 9:
                return "Nei";
            case 10:
                return "Zehn";
            case 11:
                return "Ölf";
            case 12:
                return "Zwölf";
            case 13:
                return "Dreizen";
            case 14:
                return "Vierzen";
            case 15:
                return "Viertl";
            case 16:
                return "Sechszen";
            case 17:
                return "Siebzen";
            case 18:
                return "Ochzen";
            case 19:
                return "Neinzen";
            case 20:
                return "Zwoangst";
            case 21:
                return "Oanazwoangst";
            case 22:
                return "Zworazwoangst";
            case 23:
                return "Dreiazwoangst";
            case 24:
                return "Vierazwoangst";
            case 25:
                return "Fünfazwoangst";
            case 26:
                return "Sexazwoangst";
            case 27:
                return "Siemazwoangst";
            case 28:
                return "Ochtazwoangst";
            case 29:
                return "Neinazwoangst";
            case 30:
                return "Hoiba";
            default:
                return "";
        }
    }

    function hourToText(num as Number) {
        switch (num) {
            case 0: case 12:
                return "Zwöfe";
            case 1:
                return "Oans";
            case 2:
                return "Zwoa";
            case 3: 
                return "Drei";
            case 4:
                return "Viere";
            case 5:
                return "Fünfe";
            case 6:
                return "Sechse";
            case 7:
                return "Sieme";
            case 8:
                return "Ochte";
            case 9:
                return "Neine";
            case 10:
                return "Zehne";
            case 11:
                return "Ölfe";
            default:
                return "";
        }
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get and show the current time
        var clockTime = System.getClockTime();
        var viewHigh = View.findDrawableById("LabelHigh") as Text;
        var viewMiddle = View.findDrawableById("LabelMiddle") as Text;
        var viewLow = View.findDrawableById("LabelLow") as Text;
        var viewDate = View.findDrawableById("LabelDate") as Text;
        var viewSteps = View.findDrawableById("LabelSteps") as Text;
        var viewBattery = View.findDrawableById("LabelBattery") as Text;

        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var dayString = today.day + "";
        if (today.day < 10) {
            dayString = " " + dayString;
        }
        var monthString = today.month + "";
        if (today.month < 10) {
            monthString = monthString + " ";
        }
        viewDate.setText(dayString + "/" + monthString);
        
        var hour = clockTime.hour;
        var minute = clockTime.min;
        if (clockTime.min == 0) {
            viewMiddle.setText("Punkt");
        } else if (clockTime.min < 30) {
            viewMiddle.setText("noch");
        } else if (clockTime.min > 30) {
            minute = 60 - clockTime.min;
            viewMiddle.setText("vor");
            hour = hour + 1;
        } else {
            minute = 0;
            viewMiddle.setText("hoiba");
            hour = hour + 1;
        }
        hour = hour % 12;
        var hourString = hourToText(hour);
        var minuteString = minuteToText(minute);
        viewLow.setText(hourString);
        viewHigh.setText(minuteString);

        var info = ActivityMonitor.getInfo();
        var steps = info.steps;
        viewSteps.setText("S" + steps);

        var stats = System.getSystemStats();
        var pwr = stats.battery + .5;
        var batStr = Lang.format( "$1$%", [ pwr.format( "%2d" ) ] ); 
        if (stats.charging) {
            batStr = "C" + batStr;
        } else {
            batStr = "B" + batStr;
        }
        viewBattery.setText(batStr);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
