<script setup lang="ts"></script>

<template>
  <div
    class="h-screen w-screen p-24 bg-black text-white font-semibold text-4xl flex flex-col justify-between"
  >
    <div class="flex justify-between items-start w-full">
      <div class="flex flex-col items-start">
        <DateDisplay />
        <TimeDisplay />
      </div>
      <div class="flex flex-col items-start">
        <CurrentWeatherDisplay
          api_key="6dac0748342eae5447f799779fb75e2a"
          :location_id="4782167"
        />
        <WeatherForecastDisplay
          api_key="6dac0748342eae5447f799779fb75e2a"
          :location_id="4782167"
          :days="5"
        />
      </div>
    </div>
    <div class="flex justify-center items-start w-full">
      <div class="flex flex-col items-start">
        <span>News In Progress</span>
      </div>
    </div>
  </div>
</template>
