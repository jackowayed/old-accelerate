require 'ruboto.rb'

ruboto_import_widgets :TextView

java_import "android.content.Context"
java_import "android.hardware.SensorManager"
java_import "android.graphics.drawable.ColorDrawable"
java_import "android.graphics.Color"
java_import "android.hardware.Sensor"

$activity.when_launched do |bundle|
  setTitle 'This is the Title'

  @sensors = getSystemService Context::SENSOR_SERVICE
  accelerometers = @sensors.getSensorList(Sensor::TYPE_ACCELEROMETER)
  unless accelerometers.empty?
    @accelerometer = accelerometers[0]
  end

  setup_content do
    text_view :text => "shake!"
  end

  handle_sensor_changed do |sensor_event|
    if sensor_event.sensor.getType == Sensor::TYPE_ACCELEROMETER
      vals = sensor_event.values
      Log.v "Values", vals[0].to_s
      Log.v "Values", vals[1].to_s
      Log.v "Values", vals[2].to_s
      if Math.sqrt(vals[0] ** 2 + vals[1] ** 2 + vals[2] ** 2) > 12
        getWindow.setBackgroundDrawable ColorDrawable.new(Color.rgb(rand(255), rand(255), rand(255)))
      end
    end
  end

  handle_pause do
    Log.v "SENSORREG", "unregistered accel"
    @sensors.unregisterListener self, @accelerometer
  end

  handle_resume do
    Log.v "SENSORREG", "registered accel"
    @sensors.registerListener self, @accelerometer, SensorManager::SENSOR_DELAY_UI if @accelerometer
  end
end


