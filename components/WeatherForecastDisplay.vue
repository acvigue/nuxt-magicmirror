<template>
  <div class="flex flex-col gap-3 items-center justify-end mt-6 w-72">
    <div
      v-for="day in days"
      :key="day.icon"
      class="flex w-full items-center justify-between"
    >
      <span class="text-2xl font-extralight">{{ day.weekday }}</span>
      <div class="flex items-center">
        <img
          :src="`/weather_icons/${day.icon}.png`"
          alt="Weather icon"
          class="h-12 w-12 mr-2"
        />
        <span class="text-3xl font-extralight mr-2"
          >{{ day.lowTemperature }}°</span
        >
        <span class="text-xl font-extralight text-gray-300 mr-2">-</span>
        <span class="text-3xl font-extralight">{{ day.highTemperature }}°</span>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from "vue";

const props = defineProps<{
  api_key: string;
  location_id: number;
  days: number;
}>();

const iconTable: {
  [key: string]: string;
} = {
  "01d": "01",
  "02d": "03",
  "03d": "04",
  "04d": "06",
  "09d": "09",
  "10d": "08",
  "11d": "11",
  "13d": "14",
  "50d": "13",
  "01n": "01n",
  "02n": "03n",
  "03n": "04n",
  "04n": "06n",
  "09n": "09n",
  "10n": "08n",
  "11n": "11n",
  "13n": "14n",
  "50n": "13n",
};

interface WeatherData {
  lowTemperature: number;
  highTemperature: number;
  icon: string;
  weekday: string;
}

const days = ref<WeatherData[]>([]);

const fetchWeather = async () => {
  try {
    const response = await fetch(
      `https://api.openweathermap.org/data/2.5/forecast/daily?units=imperial&id=${props.location_id}&appid=${props.api_key}`
    );
    const data = await response.json();
    days.value = [];
    for (let i = 1; i < props.days + 1; i++) {
      days.value.push({
        lowTemperature: Math.round(data.list[i].temp.min),
        highTemperature: Math.round(data.list[i].temp.max),
        icon: iconTable[data.list[i].weather[0].icon],
        weekday: new Date(data.list[i].dt * 1000).toLocaleDateString("en-US", {
          weekday: "long",
        }),
      });
    }
  } catch (error) {
    console.error(error);
  }
};

onMounted(() => {
  fetchWeather();
  const interval = setInterval(fetchWeather, 300000); // Fetch every 5 minutes
  onUnmounted(() => {
    clearInterval(interval);
  });
});
</script>
