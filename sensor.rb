require 'ruboto.rb'

java_import "android.graphics.drawable.ColorDrawable"
java_import "android.graphics.Color"
java_import "android.util.Log"
java_import "android.content.Context"
java_import "android.hardware.SensorManager"


$activity.start_ruboto_activity "$activity" do
  sensors = getSystemService Context::SENSOR_SERVICE
  Log.v "SENSORS", sensors.getSensorList(SensorManager::SENSOR_ACCELEROMETER).to_s
  Log.v "SENSOR", sensors.getSensorList(SensorManager::SENSOR_ACCELEROMETER)[0].getName
 
  setup_content do
    button :text => "foo", :width => "wrap_content" 
    #getWindow.setBackgroundDrawable ColorDrawable.new(Color.rgb(rand(255), rand(255), rand(255)))
  end
end
