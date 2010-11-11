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
  accelerometers = @sensors.getSensorList(SensorManager::SENSOR_ACCELEROMETER)
  unless accelerometers.empty?
    @accelerometer = accelerometers[0]
  end


  setup_content do
    text_view :text => "shake!"
  end

  handle_sensor_changed do |sensor, vals|
    if sensor.getType == Sensor::TYPE_ACCELEROMETER
      Log.v "SENSOR", "accel"
      getWindow.setBackgroundDrawable ColorDrawable.new(Color.rgb(rand(255), rand(255), rand(255)))
    end
  end

  handle_pause do
    @sensors.unregisterListener self, @accelerometer
  end

  handle_resume do
    @sensors.registerListener self, @accelerometer, SensorManager::SENSOR_DELAY_UI if @accelerometer
  end

end

